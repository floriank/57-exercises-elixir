defmodule TroubleShootingCars do

  import IO, only: [gets: 1, puts: 1]
  import String, only: [rstrip: 1, slice: 3]

  defmodule Question do
    defstruct text: "", right: nil, left: nil
  end

  defp question_tree do
    %Question{
      text: "Is the car silent when you turn the key?",
      left: %Question{
        text: "Are the battery terminals corroded?",
        left: %Question{
          text: "Clean terminals and try starting again!"
        },
        right: %Question{
          text: "Replace cables and try again!"
        }
      },
      right: %Question{
        text: "Does the car make a clicking noise?",
        left: %Question{
          text: "Replace the battery!"
        },
        right: %Question{
          text: "Does the car crank up but fail to start?",
          left: %Question{
            text: "Check spark plug connections."
          },
          right: %Question{
            text: "Does the engine start and then die?",
            left: %Question{
              text: "Does your car have fuel injection?",
              left: %Question{
                text: "Get it in for service"
              },
              right: %Question{
                text: "Check to ensure the choke is opening and closing."
              }
            },
            right: %Question{
              text: "Cannot help you. Bye."
            }
          }
        }
      }
    }
  end

  @doc """
  Ask the user a question, based on the current state, answer is always (y)es or (n)o
  """
  def run(question \\ question_tree) do
    if last?(question) do
      puts question.text
      puts "Thanks for playing. Come again."
    else
      answer = askp(question)
      if answer == true do
        run(question.left)
      else
        run(question.right)
      end
    end
  end

  def askp(question) do
    gets(question.text <> " ")
    |> rstrip
    |> slice(0, 1)
    |> answer
  end

  defp last?(question) do
    case {question.left, question.right} do
      {nil, nil} -> true
      _ -> false
    end
  end

  defp answer(char) do
    case char do
      "y" -> true
      "n" -> false
      _ -> false
    end
  end
end

TroubleShootingCars.run
